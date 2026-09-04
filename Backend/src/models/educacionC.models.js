import { supabase } from '../config/supabaseClient.js';

export async function getEducacionModel() {
    const { data, error } = await supabase
        .from('educacion_certificacion')
        .select('*')
        .order('orden', { ascending: true });

    if (error) throw error;
    return data;
}

export async function createEducacionModel(supabaseClient, datos) {
    const { data, error } = await supabaseClient
        .from('educacion_certificacion')
        .insert(datos)
        .select()
        .single();

    if (error) throw error;
    return data;
}

export async function updateEducacionModel(supabaseClient, id, cambios) {
  const { data, error } = await supabaseClient
    .from('educacion_certificacion')
    .update(cambios)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteEducacionModel(supabaseClient, id) {
  const { error } = await supabaseClient
    .from('educacion_certificacion')
    .delete()
    .eq('id', id);

  if (error) throw error;
  return true;
}