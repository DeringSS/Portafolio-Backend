import { supabase, createAuthedClient } from '../config/supabaseClient.js';

export async function requireAuth(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Token no proporcionado' });
  }

  const token = authHeader.split(' ')[1];

  const { data, error } = await supabase.auth.getUser(token);

  if (error || !data.user) {
    return res.status(401).json({ error: 'Token inválido o expirado' });
  }

  req.user = data.user;
  req.supabase = createAuthedClient(token); // cliente ya autenticado como este usuario
  next();
}