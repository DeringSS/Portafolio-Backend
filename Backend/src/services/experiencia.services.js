import {
    getExperienciaModel, createExperienciaModel, 
    updateExperienciaModel, deleteExperienciaModel
} from '../models/experiencia.models.js';

const CAMPOS_EDITABLES = [
  'empresa_o_proyecto', 'rol', 'tipo', 'fecha_inicio',
  'fecha_fin', 'orden',
];

function filtrarCampos(body) {
  const datos = {};
  for (const campo of CAMPOS_EDITABLES) {
    if (body[campo] !== undefined) datos[campo] = body[campo];
  }
  return datos;
}

export async function getExperienciaService() {
    const experiencia = await getExperienciaModel();
    return experiencia;
}

export async function createExperienciaService(supabaseClient, body) {
  const datos = filtrarCampos(body);

  if (!datos.empresa_o_proyecto || !datos.rol || !datos.tipo || !datos.fecha_inicio) {
    const err = new Error('empresa_o_proyecto, rol, tipo y fecha_inicio son requeridos');
    err.status = 400;
    throw err;
  }

  return await createExperienciaModel(supabaseClient, datos);
}

export async function updateExperienciaService(supabaseClient, id, body) {
  const cambios = filtrarCampos(body);

  if (Object.keys(cambios).length === 0) {
    const err = new Error('No se enviaron campos válidos para actualizar');
    err.status = 400;
    throw err;
  }

  return await updateExperienciaModel(supabaseClient, id, cambios);
}

export async function deleteExperienciaService(supabaseClient, id) {
  return await deleteExperienciaModel(supabaseClient, id);
}