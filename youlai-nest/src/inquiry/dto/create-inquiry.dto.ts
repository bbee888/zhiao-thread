import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsNotEmpty, IsOptional, IsString, MaxLength } from "class-validator";

export class CreateInquiryDto {
  @ApiProperty({ description: "姓名" })
  @IsString()
  @IsNotEmpty()
  @MaxLength(50)
  name: string;

  @ApiProperty({ description: "邮箱" })
  @IsEmail()
  @IsNotEmpty()
  @MaxLength(100)
  email: string;

  @ApiProperty({ description: "公司名称", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(100)
  company?: string;

  @ApiProperty({ description: "电话/微信", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  phone?: string;

  @ApiProperty({ description: "国家/地区" })
  @IsString()
  @IsNotEmpty()
  @MaxLength(10)
  country: string;

  @ApiProperty({ description: "感兴趣的产品", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  interest?: string;

  @ApiProperty({ description: "主题" })
  @IsString()
  @IsNotEmpty()
  @MaxLength(200)
  subject: string;

  @ApiProperty({ description: "留言内容" })
  @IsString()
  @IsNotEmpty()
  message: string;

  @ApiProperty({ description: "附件名称", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(255)
  attachmentName?: string;

  @ApiProperty({ description: "附件URL", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(1024)
  attachmentUrl?: string;

  @ApiProperty({ description: "提交语言", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(10)
  locale?: string;

  @ApiProperty({ description: "型号", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  model?: string;

  @ApiProperty({ description: "数量", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(100)
  quantity?: string;

  @ApiProperty({ description: "颜色", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  color?: string;

  @ApiProperty({ description: "长度", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  length?: string;

  @ApiProperty({ description: "强度", required: false })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  tenacity?: string;

  @ApiProperty({ description: "产品ID", required: false })
  @IsOptional()
  productId?: number;
}
