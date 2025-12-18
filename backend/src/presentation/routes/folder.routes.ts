import { Elysia } from "elysia";
import { FolderService } from "@/application/services/FolderService";
import { errorResponse, successResponse } from "@/interface/http/ApiResponse";

export const folderRoutes = (service: FolderService) =>
  new Elysia({ prefix: "/api/v1" })
    .get("/folders", async ({ set }) => {
      const folders = await service.getAllFolders();
      set.status = 200;

      return successResponse(folders, "Folders retrieved successfully");
    })

    .get("/folders/:id/children", async ({ params, set }) => {
      const children = await service.getChildren(params.id);

      if (!children) {
        set.status = 404;
        return errorResponse("Folder not found", "FOLDER_NOT_FOUND");
      }

      set.status = 200;
      return successResponse(children, "Children retrieved successfully");
    })

    .get("/folders/:id/contents", async ({ params, set }) => {
      const contents = await service.getContent(params.id);

      set.status = 200;
      return successResponse(contents, "Folder contents retrieved");
    });
