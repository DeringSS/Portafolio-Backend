import {supabase} from '../config/supabaseClient.js';

export async function getPerfilById(id) {
  const { data, error } = await supabase
    .from('usuarios')
    .select('nombre, rol')
    .eq('id', id)
    .single();

  if (error) throw error;
  return data;
}