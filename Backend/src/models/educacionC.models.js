import {supabase} from '../config/supabaseClient.js';

export async function getEducacionC() {
    const {data, error} = await supabase
    .from('educacion_certificacion')
    .select('*')
    .order('orden', { ascending: true }); 

    if (error) throw error;
    return data;
}