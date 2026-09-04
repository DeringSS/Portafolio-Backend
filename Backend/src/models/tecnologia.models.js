import {supabase} from '../config/supabaseClient.js';

export async function getTecnologiaModel() {
    const {data, error} = await supabase
    .from('tecnologia')
    .select('*');
    
    if (error) throw error;
    return data;
}

export async function createTecnologiaModel(supabaseClient, datos) {
  const { data, error } = await supabaseClient
    .from('tecnologia')
    .insert(datos)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateTecnologiaModel(supabaseClient, id, cambios) {
  const { data, error } = await supabaseClient
    .from('tecnologia')
    .update(cambios)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteTecnologiaModel(supabaseClient, id) {
  const { error } = await supabaseClient
    .from('tecnologia')
    .delete()
    .eq('id', id);

  if (error) throw error;
  return true;
}