// Menu mobile
const burger = document.querySelector('.burger');
const nav = document.querySelector('.nav');
burger.addEventListener('click', () => {
  const open = nav.classList.toggle('open');
  burger.setAttribute('aria-expanded', open);
});
nav.addEventListener('click', e => { if (e.target.tagName === 'A') nav.classList.remove('open'); });

// Onglets de la carte
document.querySelectorAll('.tab').forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelectorAll('.tab, .menu').forEach(el => el.classList.remove('active'));
    tab.classList.add('active');
    document.getElementById(tab.dataset.tab).classList.add('active');
  });
});

// Formulaire de réservation (démo : aucune donnée envoyée)
const form = document.getElementById('resa-form');
const msg = form.querySelector('.form-msg');
const dateInput = form.elements.date;
dateInput.min = new Date().toISOString().split('T')[0];

form.addEventListener('submit', e => {
  e.preventDefault();
  let ok = true;
  form.querySelectorAll('[required]').forEach(f => {
    const valid = f.checkValidity() && f.value.trim() !== '';
    f.classList.toggle('invalid', !valid);
    if (!valid) ok = false;
  });
  msg.classList.toggle('error', !ok);
  if (!ok) { msg.textContent = 'Merci de compléter correctement les champs en rouge.'; return; }
  const d = new Date(form.elements.date.value).toLocaleDateString('fr-FR', { weekday: 'long', day: 'numeric', month: 'long' });
  msg.textContent = `Merci ${form.elements.nom.value} ! Demande reçue pour ${form.elements.personnes.value} personne(s), ${d} à ${form.elements.heure.value}. Nous vous confirmons par e-mail.`;
  form.reset();
  form.elements.personnes.value = 2;
});

document.getElementById('year').textContent = new Date().getFullYear();
