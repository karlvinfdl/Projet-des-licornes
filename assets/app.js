import './stimulus_bootstrap.js';

/* ===================================== */
/* ============== LANDING DEBUT========= */
/* ===================================== */

/* ===================================== */
/* ============== LANDING FIN=========== */
/* ===================================== */

/* ===================================== */
/* =============== EQUIPE DEBUT========= */
/* ===================================== */
// Si tu décides de mettre la logique ici plutôt que dans le Twig :
document.addEventListener('DOMContentLoaded', () => {
    
    // Fonction de sélection des membres
    const handleMemberSelection = () => {
        const members = document.querySelectorAll('.js-member');
        
        members.forEach(m => {
            m.addEventListener('click', () => {
                // On enlève la classe leader à tout le monde
                members.forEach(member => member.classList.remove('leader'));
                // On l'ajoute au membre cliqué
                m.classList.add('leader');
            });
        });
    };

    handleMemberSelection();
    console.log('Système de sélection de personnage actif ! 🕹️');
});
console.log('This log comes from assets/app.js - welcome to AssetMapper! 🎉');
/* ===================================== */
/* =============== EQUIPE FIN=========== */
/* ===================================== */

/* ===================================== */
/* =============== POPUP DEBUT========== */
/* ===================================== */

/* ===================================== */
/* =============== POPUP FIN============ */
/* ===================================== */

/* ===================================== */
/* ================= FIN DEBUT========== */
/* ===================================== */

/* ===================================== */
/* ================= FIN FIN============ */
/* ===================================== */

/* ===================================== */
/* ===== RESPONSIVE DEBUT=============== */
/* ===================================== */

/* ===================================== */
/* ======= RESPONSIVE FIN=============== */
/* ===================================== */