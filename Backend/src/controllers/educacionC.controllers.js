import {
    getEducacionService, createEducacionService,
    updateEducacionService, deleteEducacionService
} from '../services/educacionC.services.js';

export async function getEducacionController(req, res) {
    try {
        const educacionC = await getEducacionService();
        return res.status(200).json(educacionC);
    } catch (error) {
        return res.status(500).json({ error: 'No se pudo obtener la educación complementaria' });
    }
}

export async function createEducacionController(req, res) {
  try {
    const nuevo = await createEducacionService(req.supabase, req.body);
    return res.status(201).json(nuevo);
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}

export async function updateEducacionController(req, res) {
  try {
    const actualizado = await updateEducacionService(req.supabase, req.params.id, req.body);
    return res.status(200).json(actualizado);
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}

export async function deleteEducacionController(req, res) {
  try {
    await deleteEducacionService(req.supabase, req.params.id);
    return res.status(204).send();
  } catch (error) {
    console.error(error);
    return res.status(error.status || 500).json({ error: error.message });
  }
}