export interface Folder {
  id: string;
  name: string;
  parent_id: string | null;
}

export interface FolderUI extends Folder {
  children?: FolderUI[];
  isOpen?: boolean;
  isLoading?: boolean;
}

export interface File {
  id: string;
  name: string;
  folder_id: string | null;
}

export async function fetchFolders(): Promise<Folder[]> {
  const res = await fetch("http://localhost:3000/api/v1/folders");
  return res.json();
}

export async function fetchChildren(id: string) {
  return fetch(`http://localhost:3000/api/v1/folders/${id}/children`).then(
    (r) => r.json()
  );
}

export async function fetchContents(id: string) {
  const res = await fetch(
    `http://localhost:3000/api/v1/folders/${id}/contents`
  );
  if (!res.ok) throw new Error("Gagal mengambil isi folder");
  return res.json();
}
