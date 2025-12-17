import { pool } from "./pool";
import { type FolderRepository } from "@/domain/repositories/FolderRepository";
import { type Folder } from "@/domain/entities/Folder";
import { type File } from "@/domain/entities/File";

export class FolderRepositoryPg implements FolderRepository {
  async findAll(): Promise<Folder[]> {
    const res = await pool.query(
      "SELECT id, name, parent_id FROM folders WHERE parent_id is null"
    );

    return res.rows.map((r) => ({
      id: r.id,
      name: r.name,
      parentId: r.parent_id,
    }));
  }

  async findChildren(parentId: string): Promise<Folder[]> {
    const res = await pool.query(
      "SELECT id, name, parent_id FROM folders WHERE parent_id = $1",
      [parentId]
    );

    return res.rows;
  }

  async findContent(folderId: string): Promise<File[]> {
    const res = await pool.query(
      "SELECT id, name, folder_id FROM files WHERE folder_id = $1",
      [folderId]
    );

    return res.rows.map((r) => ({
      id: r.id,
      name: r.name,
      folderId: r.folder_id,
    }));
  }
}
