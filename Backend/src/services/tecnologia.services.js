import {
    getTecnologiaModel, createTecnologiaModel, 
    updateTecnologiaModel, deleteTecnologiaModel
} from '../models/tecnologia.models.js';

const CAMPOS_EDITABLES = ['nombre', 'icono_url', 'categoria'];

function filtrarCampos(body) {
  const datos = {};
  for (const campo of CAMPOS_EDITABLES) {
    if (body[campo] !== undefined) datos[campo] = body[campo];
  }
  return datos;
}

export async function getTecnologiaService() {
    const tecnologia = await getTecnologiaModel();
    return tecnologia;
}

export async function createTecnologiaService(supabaseClient, body) {
  const datos = filtrarCampos(body);

  if (!datos.nombre || !datos.categoria) {
    const err = new Error('nombre y categoria son requeridos');
    err.status = 400;
    throw err;
  }

  return await createTecnologiaModel(supabaseClient, datos);
}

export async function updateTecnologiaService(supabaseClient, id, body) {
  const cambios = filtrarCampos(body);

  if (Object.keys(cambios).length === 0) {
    const err = new Error('No se enviaron campos válidos para actualizar');
    err.status = 400;
    throw err;
  }

  return await updateTecnologiaModel(supabaseClient, id, cambios);
}

export async function deleteTecnologiaService(supabaseClient, id) {
  return await deleteTecnologiaModel(supabaseClient, id);
}