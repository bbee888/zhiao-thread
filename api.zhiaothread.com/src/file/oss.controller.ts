import { Controller, Get, Param, Res } from "@nestjs/common";
import type { Response } from "express";
import { Public } from "src/common/decorators/public.decorator";
import { FileService } from "./file.service";

@Controller("oss")
export class OssController {
  constructor(private readonly fileService: FileService) {}

  @Public()
  @Get("*objectPath")
  async getObject(@Param("objectPath") objectPath: string, @Res() res: Response) {
    const { stream, contentType, contentLength } = await this.fileService.getFileStream(objectPath);
    if (contentType) res.setHeader("Content-Type", contentType);
    if (contentLength) res.setHeader("Content-Length", String(contentLength));
    res.setHeader("Cache-Control", "public, max-age=2592000, immutable");
    stream.pipe(res);
  }
}
