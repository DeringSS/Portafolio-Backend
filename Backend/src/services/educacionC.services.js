import {
    getEducacionModel, createEducacionModel,
    updateEducacionModel, deleteEducacionModel
} from '../models/educacionC.models.js';

const CAMPOS_EDITABLES = [
    'tipo', 'institucion', 'titulo', 'fecha_inicio', 'fecha_fin',
    'credencial_url', 'logo_url', 'orden',
];

function filtrarCampos(body) {
    const datos = {};
    for (const campo of CAMPOS_EDITABLES) {
        if (body[campo] !== undefined) datos[campo] = body[campo];
    }
    return datos;
}

export async function getEducacionService() {
    const educacionC = await getEducacionModel();
    return educacionC;
}

export async function createEducacionService(supabaseClient, body) {
    const datos = filtrarCampos(body);

    if (!datos.tipo || !datos.institucion || !datos.titulo) {
        const err = new Error('tipo, institucion y titulo son requeridos');
        err.status = 400;
        throw err;
    }

    return await createEducacionModel(supabaseClient, datos);
}

export async function updateEducacionService(supabaseClient, id, body) {
    const cambios = filtrarCampos(body);

    if (Object.keys(cambios).length === 0) {
        const err = new Error('No se enviaron campos válidos para actualizar');
        err.status = 400;
        throw err;
    }

    return await updateEducacionModel(supabaseClient, id, cambios);
}

export async function deleteEducacionService(supabaseClient, id) {
    return await deleteEducacionModel(supabaseClient, id);
}