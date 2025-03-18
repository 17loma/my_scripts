import webbrowser

ruta_archivo = input("Introduce la ruta completa del archivo donde estan los links: ")

with open(ruta_archivo, 'r') as file:
    links = file.readlines()


links = [link.strip() for link in links]


if not links:
    print("No hay enlaces en el archivo.")
    exit()


cantidad = int(input(f"Hay {len(links)} enlaces. ¿Cuántos quieres abrir? "))


cantidad = min(cantidad, len(links))


for i in range(cantidad):
    webbrowser.open(links[i])


with open(ruta_archivo, 'w') as file:
    file.writelines(link + '\n' for link in links[cantidad:])

print(f"Se abrieron {cantidad} enlaces y se eliminaron del archivo.")