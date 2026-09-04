import {supabase} from '../config/supabaseClient.js';

export async function getTecnologiaModel() {
    const {data, error} = await supabase
    .from('tecnologia')
    .select('*');
    
    if (error) throw error;
    return data;
}