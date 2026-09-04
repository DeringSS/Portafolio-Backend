import {
    getExperienciaService, createExperienciaService, 
    updateExperienciaService, deleteExperienciaService
} from '../services/experiencia.services.js';

export async function getExperienciaController(req, res) {
    try {
        const experiencia = await getExperienciaService();
        return res.status(200).json(experiencia);
    } catch (error) {
        return res.status(500).json({ error: 'No se pudo obtener la experiencia' });
    }
}

export async function createExperienciaController(req, res) {
  try {
    const nueva = await createExperienciaService(req.supabase, req.body);
    return res.status(201).json(nueva);
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}

export async function updateExperienciaController(req, res) {
  try {
    const actualizada = await updateExperienciaService(req.supabase, req.params.id, req.body);
    return res.status(200).json(actualizada);
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}

export async function deleteExperienciaController(req, res) {
  try {
    await deleteExperienciaService(req.supabase, req.params.id);
    return res.status(204).send();
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}