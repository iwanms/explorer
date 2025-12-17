import { Elysia } from "elysia";
import { FolderService } from "@/application/services/FolderService";

export const folderRoutes = (service: FolderService) =>
  new Elysia({ prefix: "/api/v1" })
    .get("/folders", () => service.getAllFolders())
    .get("/folders/:id/children", ({ params }) =>
      service.getChildren(params.id)
    )
    .get("/folders/:id/contents", ({ params }) =>
      service.getContent(params.id)
    );
