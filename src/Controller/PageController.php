<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PageController extends AbstractController
{
    // =========================
    // Landing
    // =========================
    #[Route('/', name: 'landing')]
    public function landing(): Response
    {
        return $this->render('page/landing.html.twig');
    }

    // =========================
    // Equipe
    // =========================
    #[Route('/equipe', name: 'equipe')]
    public function equipe(): Response
    {
        return $this->render('page/equipe.html.twig');
    }

    // =========================
    // Fin
    // =========================
    #[Route('/fin', name: 'fin')]
    public function fin(): Response
    {
        return $this->render('page/fin.html.twig');
    }
}