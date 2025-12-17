import { Elysia } from "elysia";
import { folderRoutes } from "./routes/folder.routes";
import { FolderRepositoryPg } from "@/infrastructure/db/FolderRepositoryPg";
import { FolderService } from "@/application/services/FolderService";
import { cors } from "@elysiajs/cors";

const repo = new FolderRepositoryPg();
const service = new FolderService(repo);

const app = new Elysia();

app.use(cors());
app.use(folderRoutes(service));

app.listen(3000);

console.log("🚀 API running at http://localhost:3000");
