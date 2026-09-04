import {
    getTecnologiaService, createTecnologiaService, 
    updateTecnologiaService, deleteTecnologiaService
} from '../services/tecnologia.services.js';

export async function getTecnologiaController(req, res) {
    try {
        const tecnologia = await getTecnologiaService();
        return res.status(200).json(tecnologia);
    } catch (error) {
        return res.status(500).json({ error: 'No se pudo obtener la tecnología' });
    }
}

export async function createTecnologiaController(req, res) {
  try {
    const nueva = await createTecnologiaService(req.supabase, req.body);
    return res.status(201).json(nueva);
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}

export async function updateTecnologiaController(req, res) {
  try {
    const actualizada = await updateTecnologiaService(req.supabase, req.params.id, req.body);
    return res.status(200).json(actualizada);
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}

export async function deleteTecnologiaController(req, res) {
  try {
    await deleteTecnologiaService(req.supabase, req.params.id);
    return res.status(204).send();
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}