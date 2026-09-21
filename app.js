/* =========================================================
   JÓVENES INFLUENCERS DEL SEÑOR
   APP.JS
========================================================= */


/* =========================================================
   CONFIGURACIÓN
========================================================= */

const CONFIG = {

  nombre:
    "Jóvenes Influencers del Señor",

  logo:
    "https://i.ibb.co/tw6GTfyV/Dise-o-sin-t-tulo-12.png",

  mesEspecial:
    9 // Octubre = 9 en JavaScript

};


/* =========================================================
   DATOS DE PROGRAMAS
========================================================= */

const programas = [

  {
    nombre: "Iglesia al Día",
    descripcion: "Noticias y videos de la vida de la Iglesia.",
    icono: "fa-newspaper"
  },

  {
    nombre: "Un Café con Aroma de Fe",
    descripcion: "Conversaciones para compartir y fortalecer la fe.",
    icono: "fa-mug-hot"
  },

  {
    nombre: "El Podcast",
    descripcion: "Charlas, testimonios y conversaciones.",
    icono: "fa-microphone"
  },

  {
    nombre: "El Youcat te Conecta",
    descripcion: "Fe y formación para las nuevas generaciones.",
    icono: "fa-book-open"
  },

  {
    nombre: "La Voz Líder",
    descripcion: "Historias, liderazgo y experiencias.",
    icono: "fa-microphone-lines"
  },

  {
    nombre: "Hagan lo que Él les Diga",
    descripcion: "Reflexiones y experiencias de fe.",
    icono: "fa-heart"
  },

  {
    nombre: "Una Palabra en 60 Segundos",
    descripcion: "Un mensaje breve para cada día.",
    icono: "fa-clock"
  },

  {
    nombre: "Fe y Vida Diaria",
    descripcion: "La fe llevada a nuestra vida cotidiana.",
    icono: "fa-sun"
  },

  {
    nombre: "La Santa Misa",
    descripcion: "Celebraciones litúrgicas.",
    icono: "fa-church"
  },

  {
    nombre: "Kerigma en Fuego",
    descripcion: "Evangelización y anuncio del Evangelio.",
    icono: "fa-fire"
  },

  {
    nombre: "Semilla Vocacional",
    descripcion: "Un espacio para descubrir la vocación.",
    icono: "fa-seedling"
  },

  {
    nombre: "Cultiva la Fe",
    descripcion: "Formación y crecimiento espiritual.",
    icono: "fa-leaf"
  }

];


/* =========================================================
   NOTICIAS DE EJEMPLO
========================================================= */

const noticias = [

  {
    categoria: "DIÓCESIS",
    titulo: "Noticias de la vida de la Iglesia",
    descripcion:
      "Aquí podrás publicar las noticias y acontecimientos de la Diócesis."
  },

  {
    categoria: "EVANGELIZACIÓN",
    titulo: "Compartiendo la fe en comunidad",
    descripcion:
      "Contenido evangelizador para nuestras comunidades y nuevas generaciones."
  },

  {
    categoria: "JUVENTUD",
    titulo: "Los jóvenes y la comunicación",
    descripcion:
      "Historias, experiencias y proyectos protagonizados por los jóvenes."
  },

  {
    categoria: "FORMACIÓN",
    titulo: "Formación para nuestra comunidad",
    descripcion:
      "Espacios para aprender, reflexionar y crecer en la fe."
  },

  {
    categoria: "VIDA DIOCESANA",
    titulo: "Una Iglesia que camina unida",
    descripcion:
      "Información sobre las actividades y experiencias de nuestras comunidades."
  },

  {
    categoria: "COMUNIDAD",
    titulo: "La Iglesia cerca de la gente",
    descripcion:
      "Historias y testimonios de nuestras comunidades."
  }

];


/* =========================================================
   EDITORIALES
========================================================= */

const editoriales = [

  {
    titulo: "La comunicación al servicio de la evangelización",
    descripcion:
      "Reflexiones sobre el papel de los medios de comunicación en la misión evangelizadora."
  },

  {
    titulo: "Los jóvenes y la Iglesia",
    descripcion:
      "Un espacio para reflexionar sobre la participación juvenil en la vida de la Iglesia."
  },

  {
    titulo: "Fe en tiempos digitales",
    descripcion:
      "Reflexiones sobre cómo comunicar valores y esperanza en el mundo digital."
  }

];


/* =========================================================
   PARROQUIAS
   NOTA:
   NO SE INVENTAN NOMBRES.
========================================================= */

const parroquias = [

  "Parroquia 01",
  "Parroquia 02",
  "Parroquia 03",
  "Parroquia 04",
  "Parroquia 05",
  "Parroquia 06",
  "Parroquia 07",
  "Parroquia 08"

];


/* =========================================================
   INTEGRANTES
========================================================= */

const integrantes = [

  {
    nombre: "Integrante",
    cargo: "Equipo de comunicación"
  },

  {
    nombre: "Integrante",
    cargo: "Producción audiovisual"
  },

  {
    nombre: "Integrante",
    cargo: "Contenido digital"
  },

  {
    nombre: "Integrante",
    cargo: "Evangelización"

  }

];


/* =========================================================
   FUNCIÓN PARA CREAR PROGRAMAS
========================================================= */

function renderProgramas() {

  const container =
    document.getElementById("programasGrid");

  if (!container) return;

  container.innerHTML = "";

  programas.forEach((programa, index) => {

    const card =
      document.createElement("article");

    card.className = "program-card";

    card.dataset.video = "";

    card.innerHTML = `

      <div class="program-number">
        ${String(index + 1).padStart(2, "0")}
      </div>

      <div class="program-play">
        <i class="fa-solid fa-play"></i>
      </div>

      <div class="program-content">

        <h3>
          ${programa.nombre}
        </h3>

        <span>
          ${programa.descripcion}
        </span>

      </div>

    `;

    card.addEventListener("click", () => {

      abrirVideo(
        "",
        programa.nombre
      );

    });

    container.appendChild(card);

  });

}


/* =========================================================
   FUNCIÓN PARA CREAR NOTICIAS
========================================================= */

function renderNoticias() {

  const container =
    document.getElementById("newsGrid");

  if (!container) return;

  container.innerHTML = "";

  noticias.forEach((noticia) => {

    const card =
      document.createElement("article");

    card.className = "news-card";

    card.innerHTML = `

      <div class="news-image">

        <i class="fa-solid fa-cross"></i>

      </div>

      <div class="news-content">

        <span class="news-tag">
          ${noticia.categoria}
        </span>

        <h3>
          ${noticia.titulo}
        </h3>

        <p>
          ${noticia.descripcion}
        </p>

      </div>

    `;

    container.appendChild(card);

  });

}


/* =========================================================
   FUNCIÓN PARA CREAR EDITORIALES
========================================================= */

function renderEditoriales() {

  const container =
    document.getElementById("editorialGrid");

  if (!container) return;

  container.innerHTML = "";

  editoriales.forEach((editorial) => {

    const card =
      document.createElement("article");

    card.className = "editorial-card";

    card.innerHTML = `

      <div class="editorial-icon">
        <i class="fa-solid fa-feather"></i>
      </div>

      <h3>
        ${editorial.titulo}
      </h3>

      <p>
        ${editorial.descripcion}
      </p>

    `;

    container.appendChild(card);

  });

}


/* =========================================================
   64 DATOS HISTÓRICOS
========================================================= */

function crearDatosHistoricos() {

  const container =
    document.getElementById("historicalGrid");

  if (!container) return;

  container.innerHTML = "";

  for (let i = 1; i <= 64; i++) {

    const numero =
      String(i).padStart(2, "0");

    const item =
      document.createElement("article");

    item.className = "history-item";

    item.innerHTML = `

      <div class="history-item-number">
        DATO ${numero}
      </div>

      <h4>
        Contenido histórico ${numero}
      </h4>

      <p>
        Información oficial próximamente.
      </p>

      <button
        class="history-video-btn"
        type="button"
      >
        <i class="fa-solid fa-play"></i>
        Ver video
      </button>

    `;

    const button =
      item.querySelector(
        ".history-video-btn"
      );

    button.addEventListener(
      "click",
      () => {

        abrirVideo(
          "",
          `64 Datos Históricos — Dato ${numero}`
        );

      }
    );

    container.appendChild(item);

  }

}


/* =========================================================
   PARROQUIAS
========================================================= */

function renderParroquias() {

  const container =
    document.getElementById("parishesGrid");

  if (!container) return;

  container.innerHTML = "";

  parroquias.forEach((parroquia) => {

    const card =
      document.createElement("article");

    card.className = "parish-card";

    card.innerHTML = `

      <i class="fa-solid fa-church"></i>

      <h3>
        ${parroquia}
      </h3>

      <p>
        Información próximamente.
      </p>

    `;

    container.appendChild(card);

  });

}


/* =========================================================
   INTEGRANTES
========================================================= */

function renderIntegrantes() {

  const container =
    document.getElementById("teamGrid");

  if (!container) return;

  container.innerHTML = "";

  integrantes.forEach((integrante) => {

    const card =
      document.createElement("article");

    card.className = "team-card";

    card.innerHTML = `

      <div class="team-avatar">
        <i class="fa-solid fa-user"></i>
      </div>

      <h3>
        ${integrante.nombre}
      </h3>

      <span>
        ${integrante.cargo}
      </span>

    `;

    container.appendChild(card);

  });

}


/* =========================================================
   CONTROL DEL ESPECIAL DE OCTUBRE
========================================================= */

function controlarEspecialOctubre() {

  const ahora =
    new Date();

  const esOctubre =
    ahora.getMonth() === CONFIG.mesEspecial;


  const section =
    document.getElementById(
      "datos-historicos"
    );

  const nav =
    document.getElementById(
      "datosNav"
    );


  if (!section || !nav) return;


  if (esOctubre) {

    section.classList.remove("hidden");

    nav.classList.remove("hidden");

  } else {

    section.classList.add("hidden");

    nav.classList.add("hidden");

  }

}


/* =========================================================
   MENÚ MÓVIL
========================================================= */

function configurarMenu() {

  const toggle =
    document.getElementById(
      "menuToggle"
    );

  const nav =
    document.getElementById(
      "mainNav"
    );

  if (!toggle || !nav) return;


  toggle.addEventListener(
    "click",
    () => {

      nav.classList.toggle(
        "active"
      );

      const abierto =
        nav.classList.contains(
          "active"
        );

      toggle.innerHTML =
        abierto
          ? `<i class="fa-solid fa-xmark"></i>`
          : `<i class="fa-solid fa-bars"></i>`;

    }
  );


  nav.querySelectorAll("a").forEach(
    (link) => {

      link.addEventListener(
        "click",
        () => {

          nav.classList.remove(
            "active"
          );

          toggle.innerHTML =
            `<i class="fa-solid fa-bars"></i>`;

        }
      );

    }
  );

}


/* =========================================================
   VIDEO MODAL
========================================================= */

function abrirVideo(
  videoUrl,
  titulo
) {

  const modal =
    document.getElementById(
      "videoModal"
    );

  const container =
    document.getElementById(
      "modalVideoContainer"
    );

  if (!modal || !container) return;


  /*
    Si posteriormente se agrega un enlace
    de YouTube, esta función podrá mostrarlo.
  */

  if (videoUrl) {

    const youtubeId =
      obtenerYoutubeId(
        videoUrl
      );

    if (youtubeId) {

      container.innerHTML = `

        <iframe
          class="video-iframe"
          src="https://www.youtube.com/embed/${youtubeId}"
          title="${titulo}"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
        ></iframe>

      `;

    } else {

      container.innerHTML = `

        <div class="modal-video-placeholder">

          <i class="fa-solid fa-video"></i>

          <h3>
            ${titulo}
          </h3>

          <p>
            El video estará disponible próximamente.
          </p>

        </div>

      `;

    }

  } else {

    container.innerHTML = `

      <div class="modal-video-placeholder">

        <i class="fa-solid fa-video"></i>

        <h3>
          ${titulo}
        </h3>

        <p>
          Este espacio está preparado para
          incorporar el video correspondiente.
        </p>

      </div>

    `;

  }


  modal.classList.add("active");

  modal.setAttribute(
    "aria-hidden",
    "false"
  );

  document.body.style.overflow =
    "hidden";

}


/* =========================================================
   OBTENER ID DE YOUTUBE
========================================================= */

function obtenerYoutubeId(url) {

  if (!url) return null;

  const patrones = [

    /youtube\.com\/watch\?v=([^&]+)/,

    /youtu\.be\/([^?&]+)/,

    /youtube\.com\/embed\/([^?&]+)/,

    /youtube\.com\/shorts\/([^?&]+)/

  ];


  for (const patron of patrones) {

    const resultado =
      url.match(patron);

    if (resultado) {

      return resultado[1];

    }

  }

  return null;

}


/* =========================================================
   CERRAR VIDEO
========================================================= */

function cerrarVideo() {

  const modal =
    document.getElementById(
      "videoModal"
    );

  const container =
    document.getElementById(
      "modalVideoContainer"
    );

  if (!modal) return;


  modal.classList.remove(
    "active"
  );

  modal.setAttribute(
    "aria-hidden",
    "true"
  );

  if (container) {

    container.innerHTML = "";

  }

  document.body.style.overflow =
    "";

}


/* =========================================================
   CONFIGURAR MODAL
========================================================= */

function configurarModal() {

  const close =
    document.getElementById(
      "modalClose"
    );

  const overlay =
    document.querySelector(
      ".video-modal-overlay"
    );


  if (close) {

    close.addEventListener(
      "click",
      cerrarVideo
    );

  }


  if (overlay) {

    overlay.addEventListener(
      "click",
      cerrarVideo
    );

  }


  document.addEventListener(
    "keydown",
    (event) => {

      if (
        event.key === "Escape"
      ) {

        cerrarVideo();

      }

    }
  );

}


/* =========================================================
   AÑO AUTOMÁTICO
========================================================= */

function actualizarAnio() {

  const elemento =
    document.getElementById(
      "currentYear"
    );

  if (!elemento) return;

  elemento.textContent =
    new Date().getFullYear();

}


/* =========================================================
   SCROLL SUAVE
========================================================= */

function configurarScroll() {

  document
    .querySelectorAll(
      'a[href^="#"]'
    )
    .forEach((link) => {

      link.addEventListener(
        "click",
        (event) => {

          const destino =
            link.getAttribute(
              "href"
            );

          if (
            !destino ||
            destino === "#"
          ) {

            return;

          }


          const elemento =
            document.querySelector(
              destino
            );

          if (!elemento) return;

          event.preventDefault();

          elemento.scrollIntoView({
            behavior: "smooth",
            block: "start"
          });

        }
      );

    });

}


/* =========================================================
   INICIALIZACIÓN
========================================================= */

document.addEventListener(
  "DOMContentLoaded",
  () => {

    renderProgramas();

    renderNoticias();

    renderEditoriales();

    crearDatosHistoricos();

    renderParroquias();

    renderIntegrantes();

    controlarEspecialOctubre();

    configurarMenu();

    configurarModal();

    actualizarAnio();

    configurarScroll();

  }
);
