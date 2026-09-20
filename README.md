# Jóvenes Influencers del Señor

Portal católico de comunicación y evangelización digital para la Diócesis de Ocaña.

## Tecnologías

- Next.js
- React
- TypeScript
- Supabase
- Vercel
- GitHub

## 1. Instalar

```bash
npm install
```

## 2. Configurar Supabase

Copia:

`.env.local.example`

como:

`.env.local`

y coloca:

```env
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
```

Después entra a Supabase > SQL Editor y ejecuta:

`supabase/schema.sql`

## 3. Ejecutar localmente

```bash
npm run dev
```

Abre:

http://localhost:3000

## Videos de noticias

La tabla `news` permite:

- `video_type = youtube`
- `video_type = facebook`

Ejemplos:

YouTube:
`https://www.youtube.com/watch?v=VIDEO_ID`

Facebook:
`https://www.facebook.com/PAGINA/videos/VIDEO_ID`

La aplicación transforma estos enlaces en reproductores embebidos.

## 4. GitHub

Sube el proyecto completo a un repositorio nuevo.

NO subas:

- `.env.local`
- contraseñas
- claves privadas
- `node_modules`
- `.next`

El `.gitignore` ya está preparado.

## 5. Vercel

Importa el repositorio de GitHub en Vercel.

En Vercel > Settings > Environment Variables agrega:

`NEXT_PUBLIC_SUPABASE_URL`

`NEXT_PUBLIC_SUPABASE_ANON_KEY`

con los valores de tu proyecto Supabase.

Después haz Deploy.

## Próximo paso

Este ZIP contiene la base inicial. El siguiente módulo recomendado es el panel de administración con Supabase Auth para publicar:

- Noticias
- Videos de YouTube/Facebook
- Programas
- Episodios
- Editoriales
- Parroquias
- Integrantes
- Advocaciones
