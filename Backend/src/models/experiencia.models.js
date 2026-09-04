import {supabase} from '../config/supabaseClient.js';

export async function getExperienciaModel() {
    const {data, error} = await supabase
    .from('experiencia')
    .select('*, experiencia_tecnologia(tecnologia ( id, nombre, icono_url, categoria ))')
    .order('orden', { ascending: true });
    
    if (error) throw error;
    return data;
}

export async function createExperienciaModel(supabaseClient, datos) {
  const { data, error } = await supabaseClient
    .from('experiencia')
    .insert(datos)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateExperienciaModel(supabaseClient, id, cambios) {
  const { data, error } = await supabaseClient
    .from('experiencia')
    .update(cambios)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteExperienciaModel(supabaseClient, id) {
  const { error } = await supabaseClient
    .from('experiencia')
    .delete()
    .eq('id', id);

  if (error) throw error;
  return true;
}