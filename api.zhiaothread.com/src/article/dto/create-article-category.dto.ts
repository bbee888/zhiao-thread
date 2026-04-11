import { IsOptional, IsInt, Min, Max } from "class-validator";
import { ApiPropertyOptional } from "@nestjs/swagger";
import { Type } from "class-transformer";

export class CreateArticleCategoryDto {
  @ApiPropertyOptional({ description: "排序", default: 100 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Type(() => Number)
  sort?: number = 100;

  @ApiPropertyOptional({ description: "状态 (1=启用 0=禁用)", default: 1 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(1)
  @Type(() => Number)
  status?: number = 1;

  @ApiPropertyOptional({ description: "多语言分类名称", type: Object, example: { zh: "公司新闻", en: "Company News" } })
  @IsOptional()
  langData?: Record<string, string>;
}
