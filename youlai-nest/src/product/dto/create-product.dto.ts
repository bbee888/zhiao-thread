import { IsOptional, IsInt, Min, IsNumber, IsString, Max } from "class-validator";
import { ApiProperty, ApiPropertyOptional } from "@nestjs/swagger";
import { Type } from "class-transformer";

export class CreateProductDto {
  @ApiProperty({ description: "分类 ID" })
  @IsInt()
  @Min(1)
  @Type(() => Number)
  cateId: number;

  @ApiPropertyOptional({ description: "主图", default: "" })
  @IsOptional()
  @IsString()
  cover?: string = "";

  @ApiPropertyOptional({ description: "价格", default: 0 })
  @IsOptional()
  @IsNumber()
  @Min(0)
  @Type(() => Number)
  price?: number = 0;

  @ApiPropertyOptional({ description: "型号", default: "" })
  @IsOptional()
  @IsString()
  model?: string = "";

  @ApiPropertyOptional({ description: "颜色", default: "" })
  @IsOptional()
  @IsString()
  color?: string = "";

  @ApiPropertyOptional({ description: "长度", default: "" })
  @IsOptional()
  @IsString()
  length?: string = "";

  @ApiPropertyOptional({ description: "强力", default: "" })
  @IsOptional()
  @IsString()
  tenacity?: string = "";

  @ApiPropertyOptional({ description: "排序", default: 100 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Type(() => Number)
  sort?: number = 100;

  @ApiPropertyOptional({ description: "状态 (1=上架 0=下架)", default: 1 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(1)
  @Type(() => Number)
  status?: number = 1;

  @ApiPropertyOptional({ description: "多语言产品信息", type: Object })
  @IsOptional()
  langData?: Record<string, ProductLangData>;
}

export class ProductLangData {
  @ApiProperty({ description: "产品标题" })
  @IsString()
  title: string;

  @ApiPropertyOptional({ description: "详情内容" })
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
