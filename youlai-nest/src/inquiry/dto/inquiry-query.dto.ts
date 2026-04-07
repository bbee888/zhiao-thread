import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsOptional, IsString, Min } from "class-validator";
import { Type } from "class-transformer";

export class InquiryQueryDto {
  @ApiProperty({ description: "页码", required: false, default: 1 })
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @IsOptional()
  page?: number = 1;

  @ApiProperty({ description: "每页条数", required: false, default: 10 })
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @IsOptional()
  limit?: number = 10;

  @ApiProperty({ description: "关键词（姓名/邮箱/公司/主题）", required: false })
  @IsString()
  @IsOptional()
  keywords?: string;

  @ApiProperty({ description: "状态（0-未处理 1-已处理）", required: false })
  @Type(() => Number)
  @IsInt()
  @IsOptional()
  status?: number;
}

