import { type Folder } from "../entities/Folder";
import { type File } from "../entities/File";

export interface FolderRepository {
  findAll(): Promise<Folder[]>;
  findChildren(parentId: string): Promise<Folder[]>;
  findContent(folderId: string): Promise<File[]>;
}
