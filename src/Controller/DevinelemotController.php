<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class DevinelemotController extends AbstractController
{
    #[Route('/devinelemot', name: 'app_devinelemot')]
    public function index(): Response
    {
        return $this->render('devinelemot/index.html.twig', [
            'controller_name' => 'DevinelemotController',
        ]);
    }
}
