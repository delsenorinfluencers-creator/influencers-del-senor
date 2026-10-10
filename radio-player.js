(function(){
 const STREAM='https://stream.zeno.fm/9wmjjnrd0rsvv';
 // Navegación interna sin recargar el documento: conserva el mismo elemento de audio.
 if(!window.JIS_PERSISTENT_NAV){
   window.JIS_PERSISTENT_NAV=true;
   const internalLink=a=>{
     if(!a||!a.href||a.target||a.hasAttribute('download'))return false;
     let u;try{u=new URL(a.href,location.href)}catch(e){return false}
     if(u.origin!==location.origin||!/^https?:$/.test(u.protocol))return false;
     if(u.pathname.startsWith('/admin/')||u.pathname.endsWith('.pdf')||u.pathname.endsWith('.zip'))return false;
     if(u.pathname===location.pathname&&u.search===location.search&&u.hash)return false;
     return true;
   };
   let busy=false;
   async function navigate(url,push=true){
     if(busy)return;busy=true;
     try{
       const response=await fetch(url,{headers:{'X-Requested-With':'JIS-Navigation'}});
       if(!response.ok)throw new Error('HTTP '+response.status);
       const html=await response.text();
       const doc=new DOMParser().parseFromString(html,'text/html');
       if(!doc.body||!doc.body.children.length)throw new Error('Página vacía');
       const oldDock=document.getElementById('jis-radio-dock');
       const nodes=Array.from(doc.body.childNodes).filter(n=>!(n.nodeType===1&&n.tagName==='SCRIPT'));
       const scripts=Array.from(doc.body.querySelectorAll('script'));
       document.body.replaceChildren(...nodes.map(n=>document.importNode(n,true)));
       if(oldDock)document.body.appendChild(oldDock);
       if(doc.title)document.title=doc.title;
       // Actualiza metadatos básicos sin reemplazar el documento ni el audio.
       ['description','og:title','og:description','og:image'].forEach(key=>{
         const sel=key.startsWith('og:')?`meta[property="${key}"]`:`meta[name="${key}"]`;
         const fresh=doc.head.querySelector(sel);let current=document.head.querySelector(sel);
         if(fresh){if(!current){current=document.createElement('meta');if(key.startsWith('og:'))current.setAttribute('property',key);else current.setAttribute('name',key);document.head.appendChild(current)}current.setAttribute('content',fresh.content)}
       });
       if(push)history.pushState({jis:true},'',url);
       // Ejecuta de nuevo los scripts de la página de destino, en orden.
       for(const old of scripts){
         const s=document.createElement('script');
         for(const attr of old.attributes)s.setAttribute(attr.name,attr.value);
         if(old.src){await new Promise(resolve=>{s.onload=resolve;s.onerror=resolve;document.body.appendChild(s)});}
         else {s.textContent=old.textContent;document.body.appendChild(s);s.remove();}
       }
       window.scrollTo({top:0,left:0,behavior:'instant'});
     }catch(err){console.warn('Navegación interna; se abrirá la página normalmente:',err);if(push)location.href=url;else location.reload();}
     finally{busy=false;}
   }
   document.addEventListener('click',e=>{
     if(e.defaultPrevented||e.button!==0||e.metaKey||e.ctrlKey||e.shiftKey||e.altKey)return;
     const a=e.target.closest&&e.target.closest('a');if(!internalLink(a))return;
     const u=new URL(a.href,location.href);
     if(u.pathname===location.pathname&&u.search===location.search&&u.hash){return;}
     e.preventDefault();navigate(u.href,true);
   });
   window.addEventListener('popstate',()=>navigate(location.href,false));
 }
 if(document.getElementById('jis-radio-dock'))return;
 const wrap=document.createElement('aside');wrap.id='jis-radio-dock';wrap.className='jis-radio-dock';wrap.setAttribute('aria-label','Reproductor de la emisora online');wrap.innerHTML='<div class="jis-radio-dock-inner"><img src="https://i.ibb.co/hF3t07Lt/IMG-7484.png" alt="Logo Influencers del Señor"><div class="jis-radio-info"><strong>Emisora Online</strong><span>Influencers del Señor · Radio en vivo</span></div><button type="button" id="jis-radio-toggle" aria-label="Reproducir emisora">▶</button><button type="button" id="jis-radio-hide" aria-label="Ocultar reproductor">×</button><audio id="jis-radio-audio" preload="none" playsinline></audio></div>';
 document.body.appendChild(wrap);const audio=wrap.querySelector('audio'),play=wrap.querySelector('#jis-radio-toggle');audio.src=STREAM;
 play.addEventListener('click',async()=>{try{if(audio.paused)await audio.play();else audio.pause()}catch(e){alert('No se pudo iniciar la emisora. Comprueba la conexión e inténtalo de nuevo.')}});
 audio.addEventListener('play',()=>{play.textContent='Ⅱ';play.setAttribute('aria-label','Pausar emisora');wrap.classList.add('is-playing')});audio.addEventListener('pause',()=>{play.textContent='▶';play.setAttribute('aria-label','Reproducir emisora');wrap.classList.remove('is-playing')});
 wrap.querySelector('#jis-radio-hide').addEventListener('click',()=>wrap.classList.add('is-hidden'));
})();
