(function(){
  'use strict';
  const STREAM='https://stream.zeno.fm/9wmjjnrd0rsvv';
  const KEY='jis-radio-state-v1';
  if(window.__JIS_RADIO_INITIALIZED__) return;
  window.__JIS_RADIO_INITIALIZED__=true;

  function esc(s){return String(s).replace(/[&<>\"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','\"':'&quot;'}[c]));}
  function mount(){
    if(document.getElementById('jisRadioPlayer')) return;
    const wrap=document.createElement('div');
    wrap.id='jisRadioPlayer';
    wrap.className='jis-radio-player';
    wrap.innerHTML=`
      <div class="jis-radio-inner">
        <div class="jis-radio-brand">
          <div class="jis-radio-icon" aria-hidden="true">🎙️</div>
          <div><strong>Influencers del Señor Radio</strong><span><i></i> EN VIVO</span></div>
        </div>
        <button class="jis-radio-toggle" id="jisRadioToggle" type="button" aria-label="Reproducir radio" aria-pressed="false">▶</button>
        <div class="jis-radio-now"><b>Emisora virtual</b><span>Evangelización digital</span></div>
        <button class="jis-radio-close" id="jisRadioClose" type="button" aria-label="Cerrar reproductor">×</button>
        <audio id="jisRadioAudio" preload="none" playsinline></audio>
      </div>`;
    document.body.appendChild(wrap);
    const audio=wrap.querySelector('#jisRadioAudio');
    const toggle=wrap.querySelector('#jisRadioToggle');
    const close=wrap.querySelector('#jisRadioClose');
    audio.src=STREAM;
    audio.crossOrigin='anonymous';

    function setPlaying(on){
      wrap.classList.toggle('is-playing',on);
      toggle.textContent=on?'❚❚':'▶';
      toggle.setAttribute('aria-label',on?'Pausar radio':'Reproducir radio');
      toggle.setAttribute('aria-pressed',on?'true':'false');
      try{localStorage.setItem(KEY,JSON.stringify({playing:on,closed:false}));}catch(e){}
    }
    toggle.addEventListener('click',async()=>{
      try{
        if(audio.paused){
          await audio.play();
          setPlaying(true);
        }else{
          audio.pause();
          setPlaying(false);
        }
      }catch(e){
        setPlaying(false);
        alert('No fue posible iniciar la emisora. Intenta nuevamente.');
      }
    });
    audio.addEventListener('playing',()=>setPlaying(true));
    audio.addEventListener('pause',()=>setPlaying(false));
    audio.addEventListener('error',()=>{
      wrap.classList.add('has-error');
      setPlaying(false);
    });
    close.addEventListener('click',()=>{
      audio.pause();
      wrap.classList.add('is-closed');
      try{localStorage.setItem(KEY,JSON.stringify({playing:false,closed:true}));}catch(e){}
    });
  }

  async function navigate(url,push){
    try{
      const res=await fetch(url,{headers:{'X-JIS-SPA':'1'}});
      if(!res.ok) throw new Error('HTTP '+res.status);
      const html=await res.text();
      const doc=new DOMParser().parseFromString(html,'text/html');
      const nextMain=doc.querySelector('main');
      const currentMain=document.querySelector('main');
      if(!nextMain || !currentMain) throw new Error('Página no compatible');
      currentMain.replaceWith(nextMain);
      document.title=doc.title||document.title;
      if(push) history.pushState({jisSpa:true},'',url);
      window.scrollTo({top:0,behavior:'smooth'});

      doc.querySelectorAll('script:not([src])').forEach(oldScript=>{
        const code=oldScript.textContent||'';
        if(!code.trim()) return;
        try{new Function(code)();}catch(err){console.error('JIS SPA script:',err);}
      });
      document.dispatchEvent(new CustomEvent('jis:pagechange',{detail:{url}}));
      return true;
    }catch(err){
      console.warn('Navegación interna normal:',err);
      return false;
    }
  }

  function isInternalPublic(a){
    if(!a || !a.href) return false;
    if(a.target && a.target!=='_self') return false;
    if(a.hasAttribute('download')) return false;
    if(a.origin!==location.origin) return false;
    if(a.pathname.startsWith('/admin/')) return false;
    if(a.pathname.startsWith('/api/')) return false;
    const path=a.pathname.toLowerCase();
    if(/\.(pdf|jpg|jpeg|png|gif|webp|svg|mp3|mp4|zip)$/i.test(path)) return false;
    return true;
  }

  function bind(){
    document.addEventListener('click',async e=>{
      const a=e.target.closest('a');
      if(!isInternalPublic(a)) return;
      const url=a.href;
      if(url===location.href) return;
      e.preventDefault();
      const ok=await navigate(url,true);
      if(!ok) location.href=url;
    });
    window.addEventListener('popstate',async()=>{
      const ok=await navigate(location.href,false);
      if(!ok) location.reload();
    });
  }

  function init(){mount();bind();}
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded',init); else init();
})();
