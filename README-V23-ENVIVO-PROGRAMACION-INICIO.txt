V23 - SEÑAL EN VIVO AUTOMÁTICA + PROGRAMACIÓN EN INICIO

CAMBIOS:
1. La página /en-vivo/ carga automáticamente la señal SSH101:
   https://ssh101.com/securelive/index.php?id=influencersdels&autoplay=1&muted=1

2. La portada también muestra la señal automáticamente.

3. La portada muestra al lado la PROGRAMACIÓN DEL DÍA, con el mismo formato
   de la página En vivo.

4. La programación se obtiene de public.programs en Supabase.
   Se muestran los programas con visible=true correspondientes al día actual.

5. En el panel administrativo, Programas permite editar:
   - Nombre
   - Slug
   - Descripción
   - Imagen
   - Orden
   - Visible
   - Días (1=Lun, 2=Mar, ..., 7=Dom)
   - Hora de inicio
   - Hora de fin

6. Ejecuta una sola vez:
   supabase-programacion-horarios.sql

NOTA SOBRE AUTOPLAY:
El reproductor se inicia automáticamente y en silencio (muted=1), que es la
modalidad que normalmente permiten los navegadores. El usuario puede activar
el sonido desde el propio reproductor.
