import os
import shutil

# Ruta de la carpeta temporal
temp_dir = r"C:\Users\Loma\AppData\Local\Temp"

def limpiar_temp(dir_path):
    try:
        if os.path.exists(dir_path):
            # Verifica el contenido de la carpeta
            items = os.listdir(dir_path)
            if items:
                for item in items:
                    item_path = os.path.join(dir_path, item)
                    try:
                        # Si es archivo, elimínalo
                        if os.path.isfile(item_path):
                            os.remove(item_path)
                        # Si es carpeta, elimínala de forma recursiva
                        elif os.path.isdir(item_path):
                            shutil.rmtree(item_path)
                    except Exception as e:
                        print(f"No se pudo eliminar '{item}': {e}")
                print("¡La carpeta temporal ha sido limpiada con éxito!")
            else:
                print("La carpeta temporal ya estaba vacía.")
        else:
            print(f"La ruta '{dir_path}' no existe.")
    except Exception as e:
        print(f"Error al intentar limpiar la carpeta: {e}")

# Ejecutar la función
limpiar_temp(temp_dir)
import ctypes

def mostrar_mensaje(texto, titulo):
    ctypes.windll.user32.MessageBoxW(0, texto, titulo, 0x40)

# Llama a la función después de limpiar
limpiar_temp(temp_dir)
mostrar_mensaje("La limpieza de la carpeta temporal ha finalizado.", "Limpieza Completada")


