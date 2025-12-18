import type { Folder } from "../domain/folder";

export interface FolderUI extends Folder {
  children?: FolderUI[];
  isOpen?: boolean;
  isLoading?: boolean;
}
