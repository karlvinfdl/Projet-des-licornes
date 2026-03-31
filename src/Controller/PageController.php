<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PageController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function home(): Response
    {
        return $this->redirectToRoute('landing');
    }

    #[Route('/landing', name: 'landing')]
    public function landing(): Response
    {
        return $this->render('page/landing.html.twig');
    }

    #[Route('/equipe', name: 'equipe')]
    public function equipe(): Response
    {
        return $this->render('page/equipe.html.twig');
    }

    #[Route('/fin', name: 'fin')]
    public function fin(): Response
    {
        return $this->render('page/fin.html.twig');
    }

    #[Route('/wheel', name: 'wheel')]
    public function wheel(): Response
    {
        return $this->render('page/wheel.html.twig');
    }

    #[Route('/devinelemot', name: 'devinelemot')]
    public function devinelemot(): Response
    {
        return $this->render('page/devinelemot.html.twig');
    }

    #[Route('/pinata', name: 'pinata')]
    public function pinata(): Response
    {
        return $this->render('page/pinata.html.twig');
    }

    #[Route('/scrabble', name: 'scrabble')]
    public function scrabble(): Response
    {
        return $this->render('page/scrabble.html.twig');
    }

    #[Route('/coaster', name: 'coaster')]
    public function coaster(): Response
    {
        return $this->render('page/coaster.html.twig');
    }
}