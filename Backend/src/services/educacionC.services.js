import {getEducacionC} from '../models/educacionC.models.js';

export async function obtenerEducacionC() {
    const educacionC = await getEducacionC();
    return educacionC;
}