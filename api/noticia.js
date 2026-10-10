const SUPABASE_URL = process.env.SUPABASE_URL || 'https://sqawhmimfcwnvkeviznk.supabase.co';
const SUPABASE_KEY = process.env.SUPABASE_PUBLISHABLE_KEY || process.env.SUPABASE_ANON_KEY || 'sb_publishable_IpEAQRQ7To6ONqG6MyWuuA_DM630ufy';

function esc(value = '') {
  return String(value).replace(/[&<>"']/g, c => ({ '&':'&amp;', '<':'&lt;', '>':'&gt;', '"':'&quot;', "'":'&#039;' }[c]));
}
function absoluteUrl(req, path) {
  const host = req.headers.host;
  const proto = req.headers['x-forwarded-proto'] || 'https';
  return `${proto}://${host}${path}`;
}
function stripHtml(value = '') {
  return String(value).replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim();
}
function truncate(value = '', n = 180) {
  const s = stripHtml(value);
  return s.length > n ? s.slice(0, n - 1).trimEnd() + '…' : s;
}

export default async function handler(req, res) {
  try {
    const slug = String(req.query.slug || '').trim();
    if (!slug) return res.status(400).send('Falta el identificador de la noticia.');

    const endpoint = `${SUPABASE_URL}/rest/v1/news?select=*&published=eq.true&slug=eq.${encodeURIComponent(slug)}&limit=1`;
    const response = await fetch(endpoint, {
      headers: {
        apikey: SUPABASE_KEY,
        Authorization: `Bearer ${SUPABASE_KEY}`
      }
    });
    if (!response.ok) throw new Error(`Supabase respondió ${response.status}`);
    const rows = await response.json();
    const news = rows && rows[0];
    if (!news) return res.status(404).send('Noticia no encontrada.');

    const title = news.title || 'Noticia';
    const description = truncate(news.summary || news.excerpt || news.description || news.content || 'Jóvenes Influencers del Señor - Comunicación al servicio de Dios.');
    const image = news.image_url || absoluteUrl(req, '/logo-influencers-del-senor.png');
    const canonical = absoluteUrl(req, `/iglesia-al-dia/noticia/${encodeURIComponent(news.slug || slug)}`);
    const published = news.published_at || news.created_at;
    const date = published ? new Date(published).toLocaleDateString('es-CO', {day:'2-digit', month:'long', year:'numeric'}) : '';
    const category = news.category || 'Noticias';
    const author = news.author_name || 'Redacción';

    const content = news.content || news.summary || news.excerpt || '';
    const safeContent = /<[^>]+>/.test(content) ? content : `<p>${esc(content).replace(/\n\n/g, '</p><p>').replace(/\n/g, '<br>')}</p>`;

    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.setHeader('Cache-Control', 'public, s-maxage=60, stale-while-revalidate=300');
    return res.status(200).send(`<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)} | Jóvenes Influencers del Señor</title>
<meta name="description" content="${esc(description)}">
<link rel="canonical" href="${esc(canonical)}">
<link rel="icon" href="${absoluteUrl(req, '/favicon.svg')}">
<meta property="og:type" content="article">
<meta property="og:site_name" content="Jóvenes Influencers del Señor">
<meta property="og:locale" content="es_CO">
<meta property="og:title" content="${esc(title)}">
<meta property="og:description" content="${esc(description)}">
<meta property="og:url" content="${esc(canonical)}">
<meta property="og:image" content="${esc(image)}">
<meta property="og:image:alt" content="${esc(title)}">
<meta property="og:image:type" content="image/jpeg">
${published ? `<meta property="article:published_time" content="${esc(new Date(published).toISOString())}">` : ''}
<meta property="article:section" content="${esc(category)}">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="${esc(title)}">
<meta name="twitter:description" content="${esc(description)}">
<meta name="twitter:image" content="${esc(image)}">
<link rel="stylesheet" href="/estilos.css">
<style>
  .share-card{max-width:980px;margin:60px auto;padding:0 18px 70px}.share-card article{background:#fff;border:1px solid #e7dfd2;border-radius:25px;overflow:hidden;box-shadow:0 15px 45px rgba(48,33,22,.10)}
  .share-card .hero-image{display:block;width:100%;max-height:620px;object-fit:cover;background:#eee}.share-card .body{padding:32px}.share-card h1{font-size:clamp(34px,5vw,58px);line-height:1.02;margin:10px 0 14px}.share-card .meta{color:#756b62;font-size:14px;margin-bottom:25px}.share-card .content{font-size:18px;line-height:1.8;color:#493d34}.share-card .content p{margin:0 0 18px}.share-card .buttons{display:flex;flex-wrap:wrap;gap:10px;margin-top:30px}.share-card .btn{display:inline-flex;align-items:center;padding:12px 18px;border-radius:999px;background:#21180f;color:#fff;text-decoration:none;font-weight:800}.share-card .btn.alt{background:#fff;color:#21180f;border:1px solid #e7dfd2}
</style>
</head>
<body>
<header class="header"><div class="container bar"><a class="brand" href="/"><img src="/logo-influencers-del-senor.png" alt="Logo"><span>Jóvenes Influencers<br><small>del Señor</small></span></a><nav class="nav" style="display:flex"><a href="/">Inicio</a><a href="/iglesia-al-dia/">Iglesia al Día</a><a href="/programas/">Programas</a><a href="/en-vivo/">En Vivo</a><a href="/quienes-somos/">Quiénes somos</a></nav></div></header>
<main class="share-card"><article>
${image ? `<img class="hero-image" src="${esc(image)}" alt="${esc(title)}">` : ''}
<div class="body"><span class="tag">${esc(category)}</span><h1>${esc(title)}</h1>
<div class="meta">Publicado por <b>${esc(author)}</b>${date ? ` · ${esc(date)}` : ''}</div>
<div class="content">${safeContent}</div>
<div class="buttons"><a class="btn" target="_blank" rel="noopener" href="https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(canonical)}">Compartir en Facebook</a><a class="btn alt" href="/iglesia-al-dia/">← Volver a noticias</a></div>
</div></article></main>
<footer><div class="container footer"><img src="/logo-influencers-del-senor.png" alt="Logo"><div class="footer-center"><strong>Jóvenes Influencers del Señor</strong><p>Comunicación al servicio de Dios.</p><p>© ${new Date().getFullYear()} Jóvenes Influencers del Señor</p><div class="footer-creator">Creado por <b>Gamarra TV</b></div></div></div></footer>
</body></html>`);
  } catch (error) {
    console.error(error);
    return res.status(500).send('No fue posible cargar la noticia.');
  }
}
