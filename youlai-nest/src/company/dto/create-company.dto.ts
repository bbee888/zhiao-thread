import { IsString, IsInt, IsOptional, IsObject } from "class-validator";

export class CompanyLangData {
  @IsString()
  @IsOptional()
  title?: string;

  @IsString()
  @IsOptional()
  content?: string;

  @IsString()
  @IsOptional()
  seoTitle?: string;

  @IsString()
  @IsOptional()
  seoKeywords?: string;

  @IsString()
  @IsOptional()
  seoDescription?: string;
}

export class CreateCompanyDto {
  @IsString()
  @IsOptional()
  logo?: string;

  @IsString()
  @IsOptional()
  cover?: string;

  @IsInt()
  @IsOptional()
  sort?: number;

  @IsInt()
  @IsOptional()
  status?: number;

  @IsObject()
  @IsOptional()
  langData?: Record<string, CompanyLangData>;
}
