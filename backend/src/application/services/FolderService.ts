import { type FolderRepository } from "@/domain/repositories/FolderRepository";

export class FolderService {
  constructor(private repo: FolderRepository) {}

  getAllFolders() {
    return this.repo.findAll();
  }

  getChildren(parentId: string) {
    return this.repo.findChildren(parentId);
  }

  getContent(folderId: string) {
    return this.repo.findContent(folderId);
  }
}
