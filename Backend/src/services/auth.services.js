import {supabase} from '../config/supabaseClient.js';
import { getPerfilById } from '../models/auth.models.js';

export async function loginUsuario(email, password) {
  const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
    email,
    password,
  });

  if (authError) {
    const err = new Error(authError.message);
    err.status = 401;
    throw err;
  }

  const perfil = await getPerfilById(authData.user.id);

  return {
    user: {
      id: authData.user.id,
      email: authData.user.email,
      nombre: perfil.nombre,
      rol: perfil.rol,
    },
    session: authData.session,
  };
}