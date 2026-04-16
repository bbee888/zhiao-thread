import { Module } from "@nestjs/common";
import { FileService } from "./file.service";
import { FileController } from "./file.controller";
import { OssController } from "./oss.controller";

@Module({
  controllers: [FileController, OssController],
  providers: [FileService],
  exports: [FileService],
})
export class FileModule {}
