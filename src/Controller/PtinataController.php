<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class PtinataController extends AbstractController
{
    #[Route('/ptinata', name: 'app_ptinata')]
    public function index(): Response
    {
        return $this->render('ptinata/index.html.twig', [
            'controller_name' => 'PtinataController',
        ]);
    }
}
