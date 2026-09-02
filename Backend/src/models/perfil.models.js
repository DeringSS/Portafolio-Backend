import {supabase} from '../config/supabaseClient.js';

export async function getPerfil() {
    const {data, error} = await supabase
    .from('perfil')
    .select('*')
    .single();

    if (error) throw error;
    return data;
}

export async function updatePerfil(supabaseClient, id, cambios) {
  const { data, error } = await supabaseClient
    .from('perfil')
    .update(cambios)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  return data;
}