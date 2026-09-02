import { loginUsuario } from '../services/auth.services.js';

export async function login(req, res) {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'Email y password son requeridos' });
  }

  try {
    const result = await loginUsuario(email, password);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(error.status || 500).json({ error: error.message });
  }
}