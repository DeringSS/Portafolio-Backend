import { getPerfil, updatePerfil } from '../models/perfil.models.js';

const CAMPOS_EDITABLES = [
  'nombre',
  'rol_titulo',
  'frase_diferenciadora',
  'bio_corta',
  'bio_larga',
  'foto_url',
  'cta_texto',
  'cta_link',
  'email',
  'github_url',
  'linkedin_url',
  'cv_url_activo',
];

export async function obtenerPerfil() {
  const perfil = await getPerfil();
  return perfil;
}

export async function actualizarPerfil(supabaseClient, id, body) {
  const cambios = {};
  for (const campo of CAMPOS_EDITABLES) {
    if (body[campo] !== undefined) cambios[campo] = body[campo];
  }

  if (Object.keys(cambios).length === 0) {
    const err = new Error('No se enviaron campos válidos para actualizar');
    err.status = 400;
    throw err;
  }

  return await updatePerfil(supabaseClient, id, cambios);
}