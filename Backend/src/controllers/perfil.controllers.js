import { obtenerPerfil, actualizarPerfil } from '../services/perfil.services.js';

export async function getPerfilPublico(req, res) {
  try {
    const perfil = await obtenerPerfil();
    return res.status(200).json(perfil);
  } catch (error) {
    return res.status(500).json({ error: 'No se pudo obtener el perfil' });
  }
}

export async function editarPerfil(req, res) {
  try {
    const perfil = await actualizarPerfil(req.supabase, req.user.id, req.body);
    return res.status(200).json(perfil);
  } catch (error) {
    return res.status(error.status || 500).json({ error: error.message });
  }
}