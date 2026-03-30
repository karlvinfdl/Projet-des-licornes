<?php

namespace App\Controller;

use App\Entity\Score;
use App\Repository\ScoreRepository;
use App\Repository\WordRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/jeux')]
class ScrabbleController extends AbstractController
{
    private const MAX_SCORE = 1230;

    #[Route('', name: 'jeux_index')]
    public function index(): Response
    {
        return $this->render('scrabble/index.html.twig');
    }

    #[Route('/api/mots', name: 'jeux_api_mots')]
    public function apiMots(WordRepository $wordRepository): JsonResponse
    {
        $grouped = $wordRepository->findGroupedByDifficulty();

        return $this->json([
            'regles' => [
                'easy' => ['ptsWord' => 8, 'bonusTemps' => 1, 'tickets' => 1],
                'medium' => ['ptsWord' => 12, 'bonusTemps' => 2, 'tickets' => 2],
                'hard' => ['ptsWord' => 18, 'bonusTemps' => 3, 'tickets' => 3],
            ],
            'mots' => [
                'facile' => $grouped['easy'],
                'moyen' => $grouped['medium'],
                'difficile' => $grouped['hard'],
            ],
            'indices' => $grouped['hints'],
        ]);
    }

    #[Route('/score/save', name: 'jeux_score_save', methods: ['POST'])]
    public function saveScore(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!is_array($data)) {
            return $this->json(['error' => 'Invalid JSON'], 400);
        }

        $player = trim((string) ($data['player'] ?? 'Joueur'));
        if ($player === '') {
            $player = 'Joueur';
        }
        $player = mb_substr($player, 0, 60);

        $scoreVal = (int) ($data['score'] ?? 0);
        $scoreVal = max(0, min($scoreVal, self::MAX_SCORE));

        $score = new Score();
        $score->setPlayer($player)
            ->setScore($scoreVal)
            ->setWin((bool) ($data['win'] ?? false))
            ->setFound((int) ($data['found'] ?? 0))
            ->setTarget((int) ($data['target'] ?? 10));

        $em->persist($score);
        $em->flush();

        return $this->json(['ok' => true, 'id' => $score->getId()], 201);
    }

    #[Route('/api/scores', name: 'jeux_api_scores')]
    public function scores(ScoreRepository $repo): JsonResponse
    {
        $scores = $repo->findTop10();

        return $this->json(array_map(fn(Score $s) => $s->toArray(), $scores));
    }
}
