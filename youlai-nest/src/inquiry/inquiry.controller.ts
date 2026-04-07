import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req } from "@nestjs/common";
import { ApiOperation, ApiTags } from "@nestjs/swagger";
import { Public, Permissions } from "src/common/decorators/public.decorator";
import { InquiryService } from "./inquiry.service";
import { CreateInquiryDto } from "./dto/create-inquiry.dto";
import { InquiryQueryDto } from "./dto/inquiry-query.dto";
import { UpdateInquiryStatusDto } from "./dto/update-inquiry-status.dto";

@ApiTags("10.询盘接口")
@Controller("inquiries")
export class InquiryController {
  constructor(private readonly inquiryService: InquiryService) {}

  @ApiOperation({ summary: "新增询盘（前台提交）" })
  @Public()
  @Post()
  async create(@Body() dto: CreateInquiryDto, @Req() req: any) {
    const ip = req?.ip || req?.headers?.["x-forwarded-for"] || "";
    const userAgent = req?.headers?.["user-agent"] || "";
    return await this.inquiryService.create(dto, { ip: String(ip), userAgent: String(userAgent) });
  }

  @ApiOperation({ summary: "询盘分页列表" })
  @Get()
  @Permissions("inquiry:list")
  async findPage(@Query() query: InquiryQueryDto) {
    return await this.inquiryService.findPage(query);
  }

  @ApiOperation({ summary: "询盘详情" })
  @Get(":id")
  @Permissions("inquiry:detail")
  async findOne(@Param("id") id: string) {
    return await this.inquiryService.findOne(id);
  }

  @ApiOperation({ summary: "修改询盘状态" })
  @Patch(":id/status")
  @Permissions("inquiry:update")
  async updateStatus(@Param("id") id: string, @Body() dto: UpdateInquiryStatusDto) {
    return await this.inquiryService.updateStatus(id, dto.status);
  }

  @ApiOperation({ summary: "删除询盘" })
  @Delete(":id")
  @Permissions("inquiry:delete")
  async delete(@Param("id") id: string) {
    return await this.inquiryService.delete(id);
  }
}

