import type { ApiResponse } from "../types/api";
import type { Folder } from "../types/domain/folder";
import type { FileItem } from "../types/domain/file";

export async function fetchFolders(): Promise<ApiResponse<Folder[]>> {
  const res = await fetch("http://localhost:3000/api/v1/folders");
  if (!res.ok) {
    throw new Error("Failed to fetch folders");
  }
  return res.json();
}

export async function fetchChildren(
  id: string
): Promise<ApiResponse<Folder[]>> {
  const res = await fetch(
    `http://localhost:3000/api/v1/folders/${id}/children`
  );

  if (!res.ok) {
    throw new Error("Failed to fetch folder children");
  }

  return res.json();
}

export async function fetchContents(
  id: string
): Promise<ApiResponse<FileItem[]>> {
  const res = await fetch(
    `http://localhost:3000/api/v1/folders/${id}/contents`
  );

  if (!res.ok) {
    throw new Error("Failed to fetch folder contents");
  }

  return res.json();
}
