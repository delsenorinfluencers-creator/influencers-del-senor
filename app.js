const programas = [
  ["Un Café con Aroma de Fe", "Entrevistas y conversaciones desde la fe."],
  ["El Podcast", "Conversaciones, testimonios y actualidad."],
  ["El Youcat te Conecta", "Formación católica para jóvenes."],
  ["La Voz Líder", "Voces de liderazgo y servicio."],
  ["Hagan lo que Él les Diga", "Evangelio y reflexión."],
  ["Una Palabra en 60 Segundos", "Reflexiones breves para cada día."],
  ["Fe y Vida Diaria", "La fe llevada a la vida cotidiana."],
  ["La Santa Misa", "Celebraciones y transmisiones."],
  ["Kerigma en Fuego", "Anuncio del Evangelio y testimonios."],
  ["Semilla Vocacional", "Historias y contenido vocacional."],
  ["Cultiva la Fe", "Formación y crecimiento espiritual."]
];

const programasLista = document.getElementById("programasLista");

programas.forEach(([titulo, descripcion]) => {
  const tarjeta = document.createElement("article");
  tarjeta.className = "programa";
  tarjeta.innerHTML = `
    <h3>${titulo}</h3>
    <p>${descripcion}</p>
    <span>🎥 Próximamente</span>
  `;
  programasLista.appendChild(tarjeta);
});

// Se preparan los 64 espacios históricos.
// Los títulos y videos reales se cargarán posteriormente desde Supabase.
const datosHistoricos = document.getElementById("datosHistoricos");

for (let numero = 1; numero <= 64; numero++) {
  const tarjeta = document.createElement("article");
  tarjeta.className = "dato";
  tarjeta.innerHTML = `
    <span class="numero">DATO ${numero} DE 64</span>
    <h3>Dato histórico #${numero}</h3>
    <p>Contenido histórico de la Diócesis de Ocaña.</p>
    <div class="video-placeholder">🎥 Video histórico</div>
  `;
  datosHistoricos.appendChild(tarjeta);
}

// Menú móvil
const menuBtn = document.getElementById("menuBtn");
const menu = document.getElementById("menu");

menuBtn.addEventListener("click", () => {
  menu.classList.toggle("abierto");
});

// Cerrar menú al seleccionar una sección
menu.querySelectorAll("a").forEach((link) => {
  link.addEventListener("click", () => {
    menu.classList.remove("abierto");
  });
});

// Mostrar/ocultar el especial según el mes.
// El proyecto queda preparado para octubre de 2026.
const hoy = new Date();
const inicioEspecial = new Date("2026-10-01T00:00:00");
const finEspecial = new Date("2026-11-01T00:00:00");

const especial = document.querySelector(".especial");

if (hoy >= inicioEspecial && hoy < finEspecial) {
  especial.style.display = "block";
} else {
  especial.style.display = "none";
}
