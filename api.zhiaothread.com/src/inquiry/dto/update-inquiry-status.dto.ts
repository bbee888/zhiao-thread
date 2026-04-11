import { ApiProperty } from "@nestjs/swagger";
import { IsInt, Min } from "class-validator";
import { Type } from "class-transformer";

export class UpdateInquiryStatusDto {
  @ApiProperty({ description: "状态（0-未处理 1-已处理）" })
  @Type(() => Number)
  @IsInt()
  @Min(0)
  status: number;
}

