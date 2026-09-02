import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  throw new Error('Faltan variables de entorno de Supabase (SUPABASE_URL / SUPABASE_ANON_KEY)');
}

// Cliente anónimo: para lecturas públicas y para verificar tokens (auth.getUser)
export const supabase = createClient(supabaseUrl, supabaseKey);

// Cliente autenticado como un usuario específico: para escrituras que deben respetar RLS
export function createAuthedClient(accessToken) {
  return createClient(supabaseUrl, supabaseKey, {
    global: { headers: { Authorization: `Bearer ${accessToken}` } },
  });
}

export async function testConnection() {
  const response = await fetch(`${supabaseUrl}/auth/v1/health`, {
    method: 'GET',
    headers: { apikey: supabaseKey },
  });

  if (!response.ok) {
    throw new Error(`No se pudo conectar a la base de datos: HTTP ${response.status}`);
  }

  return true;
}