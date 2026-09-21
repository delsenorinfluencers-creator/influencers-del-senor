
const C=window.JIS_CONFIG||{};
function shell(title,content){
 document.title=title+" | Jóvenes Influencers del Señor";
 return `<header class="header"><div class="container bar">
 <a class="brand" href="/"><img src="${C.logo}" alt="Jóvenes Influencers del Señor"><span>Jóvenes Influencers<br><small>del Señor</small></span></a>
 <nav class="nav" id="nav"><a href="/">Inicio</a><a href="/iglesia-al-dia/">Iglesia al Día</a><a href="/programas/">Programas</a><a href="/en-vivo/">🔴 En Vivo</a><a href="/64-datos/">64 Datos</a><a href="/diocesis/">Diócesis</a><a href="/editorial/">Editorial</a><a href="/quienes-somos/">Quiénes somos</a><a class="login-link" href="/admin/">🔐 Iniciar sesión</a></nav>
 <button class="search-btn" id="searchBtn" aria-label="Buscar">⌕</button><button class="menu" id="menuBtn" aria-label="Menú">☰</button>
 </div><div class="search-panel" id="searchPanel"><div class="container"><form class="search-form" id="searchForm"><input id="searchInput" placeholder="Buscar noticias, programas, editoriales..." autocomplete="off"><button class="btn" type="submit">Buscar</button></form><div id="searchResults" class="search-results"></div></div></div></header><main>${content}</main>
 <footer><div class="container footer"><img src="${C.logo}" alt="Logo"><div><strong>Jóvenes Influencers del Señor</strong><p>Comunicación al servicio de Dios.</p><p>Medio de comunicación católico de la Diócesis de Ocaña.</p><div class="footer-links"><a href="/iglesia-al-dia/">Noticias</a><a href="/programas/">Programas</a><a href="/en-vivo/">En vivo</a><a href="/quienes-somos/">Quiénes somos</a><a target="_blank" rel="noopener" href="https://www.facebook.com/jovenesinfluencersdelsenor">Facebook</a></div></div></div><div class="created">Sitio web creado por <b>Gamarra TV</b></div></footer>`;
}
function esc(v){return String(v??"").replace(/[&<>"']/g,m=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#039;"}[m]))}
function embed(url){if(!url)return "";let u=url;if(url.includes("youtube.com/watch?v="))u="https://www.youtube.com/embed/"+url.split("v=")[1].split("&")[0];if(url.includes("youtu.be/"))u="https://www.youtube.com/embed/"+url.split("youtu.be/")[1].split("?")[0];return `<div class="video"><iframe src="${u}" title="Video" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen loading="lazy"></iframe></div>`}
function supabaseClient(){return window.supabase.createClient(window.SUPABASE_URL,window.SUPABASE_PUBLISHABLE_KEY)}
async function getLiveStream(){try{const sb=supabaseClient();const {data}=await sb.from("live_streams").select("*").eq("active",true).order("updated_at",{ascending:false}).limit(1).maybeSingle();return data||null}catch(e){return null}}
function facebookEmbed(url){if(!url)return "";return `<div class="video live-facebook"><iframe src="https://www.facebook.com/plugins/video.php?href=${encodeURIComponent(url)}&show_text=false&width=1280" scrolling="no" frameborder="0" allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share" allowfullscreen></iframe></div>`}
async function renderLiveBlock(id="liveBlock"){
 const el=document.getElementById(id);if(!el)return;const live=await getLiveStream();
 if(live&&live.facebook_url){el.innerHTML=`<div class="live-card"><div class="live-card-head"><span class="live-badge"><span class="dot"></span> EN VIVO</span><span>${esc(live.title||"Jóvenes Influencers del Señor")}</span></div>${facebookEmbed(live.facebook_url)}<div class="live-card-body"><h2>${esc(live.title||"Jóvenes Influencers del Señor")}</h2>${live.description?`<p>${esc(live.description)}</p>`:""}<a class="btn live" target="_blank" rel="noopener" href="${esc(live.facebook_url)}">Ver en Facebook ↗</a></div></div>`}
 else el.innerHTML=`<div class="live-off"><div class="tv-icon">📺</div><h2>Actualmente no estamos transmitiendo</h2><p class="intro" style="margin:auto">Cuando iniciemos una transmisión, el reproductor aparecerá aquí automáticamente.</p><a class="btn alt" target="_blank" rel="noopener" href="https://www.facebook.com/jovenesinfluencersdelsenor">Visitar Facebook</a></div>`;
}
async function loadNews(target="news",limit=9){
 const el=document.getElementById(target);if(!el)return;
 try{const sb=supabaseClient();const {data,error}=await sb.from("news").select("*").eq("published",true).order("published_at",{ascending:false}).limit(limit);if(error)throw error;
 if(!data?.length){el.innerHTML=`<div class="notice">Muy pronto encontrarás aquí las últimas noticias de Jóvenes Influencers del Señor.</div>`;return}
 el.innerHTML=`<div class="news-grid">${data.map(n=>`<article class="card news-card">${n.image_url?`<img src="${esc(n.image_url)}" alt="${esc(n.title)}" loading="lazy">`:""}<div class="body"><small>IGLESIA AL DÍA</small><h3>${esc(n.title)}</h3><p>${esc(n.excerpt||"Conoce esta noticia y sus contenidos audiovisuales.")}</p>${n.youtube_url?embed(n.youtube_url):n.facebook_url?facebookEmbed(n.facebook_url):""}</div></article>`).join("")}</div>`;
 }catch(e){el.innerHTML=`<div class="notice">No se pudieron cargar las noticias en este momento.</div>`}
}
async function loadHistory(target="history"){
 const el=document.getElementById(target);if(!el)return;
 try{const sb=supabaseClient();const {data,error}=await sb.from("historical_64").select("*").eq("published",true).order("number");if(error)throw error;
 if(!data?.length){el.innerHTML=`<div class="notice">Los 64 datos históricos se publicarán durante octubre de 2026.</div>`;return}
 el.innerHTML=data.map(x=>`<article class="card"><span class="program-number">${esc(x.number)}</span><h3>${esc(x.title)}</h3><p>${esc(x.content||"")}</p>${x.youtube_url?embed(x.youtube_url):x.facebook_url?facebookEmbed(x.facebook_url):""}</article>`).join("");
 }catch(e){el.innerHTML=`<div class="notice">No se pudieron cargar los datos históricos todavía.</div>`}
}
async function searchSite(q){
 const box=document.getElementById("searchResults");if(!box)return;if(!q.trim()){box.innerHTML="";return}
 box.innerHTML="Buscando...";
 try{const sb=supabaseClient();const [n,e]=await Promise.all([sb.from("news").select("title,excerpt").eq("published",true).ilike("title",`%${q}%`).limit(5),sb.from("editorials").select("title,excerpt").eq("published",true).ilike("title",`%${q}%`).limit(5)]);
 const arr=[...(n.data||[]).map(x=>({...x,url:"/iglesia-al-dia/"})),...(e.data||[]).map(x=>({...x,url:"/editorial/"}))];box.innerHTML=arr.length?arr.map(x=>`<a class="search-result" href="${x.url}"><b>${esc(x.title)}</b><br><small>${esc(x.excerpt||"Ver contenido")}</small></a>`).join(""):`No encontramos resultados para <b>${esc(q)}</b>.`;
 }catch(e){box.innerHTML="No se pudo realizar la búsqueda."}
}
document.addEventListener("DOMContentLoaded",()=>{
 const b=document.getElementById("menuBtn"),nav=document.getElementById("nav"),s=document.getElementById("searchBtn"),panel=document.getElementById("searchPanel"),form=document.getElementById("searchForm");
 if(b)b.onclick=()=>nav?.classList.toggle("open");
 if(s)s.onclick=()=>{panel?.classList.toggle("open");document.getElementById("searchInput")?.focus()};
 if(form)form.onsubmit=e=>{e.preventDefault();searchSite(document.getElementById("searchInput").value)};
});
