import { IsOptional, IsInt, Min, IsString, Max } from "class-validator";
import { ApiProperty, ApiPropertyOptional } from "@nestjs/swagger";
import { Type } from "class-transformer";

export class CreateArticleDto {
  @ApiProperty({ description: "分类 ID" })
  @IsInt()
  @Min(1)
  @Type(() => Number)
  cateId: number;

  @ApiPropertyOptional({ description: "封面图", default: "" })
  @IsOptional()
  @IsString()
  cover?: string = "";

  @ApiPropertyOptional({ description: "排序", default: 100 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Type(() => Number)
  sort?: number = 100;

  @ApiPropertyOptional({ description: "状态 (1=发布 0=隐藏)", default: 1 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(1)
  @Type(() => Number)
  status?: number = 1;

  @ApiPropertyOptional({ description: "多语言文章信息", type: Object })
  @IsOptional()
  langData?: Record<string, ArticleLangData>;
}

export class ArticleLangData {
  @ApiProperty({ description: "文章标题" })
  @IsString()
  title: string;

  @ApiPropertyOptional({ description: "内容" })
  @IsOptional()
  @IsString()
  content?: string;

  @ApiPropertyOptional({ description: "关键词" })
  @IsOptional()
  @IsString()
  keywords?: string;

  @ApiPropertyOptional({ description: "描述" })
  @IsOptional()
  @IsString()
  description?: string;
}
